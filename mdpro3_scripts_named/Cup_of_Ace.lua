--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 圣杯A  (ID: 37812118)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：进行1次投掷硬币。表的场合，自己从卡组抽2张。里的场合，对方从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--カップ・オブ・エース
function c37812118.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c37812118.target)
	e1:SetOperation(c37812118.activate)
	c:RegisterEffect(e1)
end
function c37812118.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and Duel.IsPlayerCanDraw(1-tp,2) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c37812118.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then Duel.Draw(tp,2,REASON_EFFECT)
	else Duel.Draw(1-tp,2,REASON_EFFECT) end
end
