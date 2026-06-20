--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 命运的分岔道  (ID: 50470982)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方玩家各自进行1次投掷硬币。出现表侧的场合回复2000基本分，出现里侧的场合基本分受到2000分伤害。
--[[ __CARD_HEADER_END__ ]]

--運命の分かれ道
function c50470982.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c50470982.target)
	e1:SetOperation(c50470982.activate)
	c:RegisterEffect(e1)
end
function c50470982.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,PLAYER_ALL,1)
end
function c50470982.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then Duel.Recover(tp,2000,REASON_EFFECT)
	else Duel.Damage(tp,2000,REASON_EFFECT) end
	res=Duel.TossCoin(1-tp,1)
	if res==1 then Duel.Recover(1-tp,2000,REASON_EFFECT)
	else Duel.Damage(1-tp,2000,REASON_EFFECT) end
end
