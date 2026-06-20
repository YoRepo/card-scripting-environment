--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 第六感  (ID: 3280747)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己在1至6的范围里宣言2个数字。对方丢出1个「骰子」，丢出的数目是宣言的数字的其中1个，自己就抽相等数目的卡。猜不中的场合，自己卡组从上面丢弃「骰子」丢出数目的卡去墓地。
--[[ __CARD_HEADER_END__ ]]

--第六感
function c3280747.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DECKDES+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c3280747.target)
	e1:SetOperation(c3280747.activate)
	c:RegisterEffect(e1)
end
function c3280747.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=6 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,2)
end
function c3280747.activate(e,tp,eg,ep,ev,re,r,rp)
	local t={}
	local i=1
	local p=1
	for i=1,6 do t[i]=i end
	local a1=Duel.AnnounceNumber(tp,table.unpack(t))
	for i=1,6 do
		if a1~=i then t[p]=i p=p+1 end
	end
	t[p]=nil
	local a2=Duel.AnnounceNumber(tp,table.unpack(t))
	local dc=Duel.TossDice(1-tp,1)
	if dc==a1 or dc==a2 then Duel.Draw(tp,dc,REASON_EFFECT)
	else Duel.DiscardDeck(tp,dc,REASON_EFFECT) end
end
