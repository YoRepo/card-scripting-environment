--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 哥布林偷窥者  (ID: 52263685)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 172
--
-- Effect Text:
-- 对方从卡组上面把3张卡翻开。自己从那之中选择1张回到对方卡组最下面，剩下的卡用喜欢的顺序回到对方卡组上面。
--[[ __CARD_HEADER_END__ ]]

--盗み見ゴブリン
function c52263685.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c52263685.target)
	e1:SetOperation(c52263685.activate)
	c:RegisterEffect(e1)
end
function c52263685.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>=3 end
	Duel.SetTargetPlayer(tp)
end
function c52263685.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if Duel.GetFieldGroupCount(p,0,LOCATION_DECK)==0 then return end
	Duel.ConfirmDecktop(1-p,3)
	local g=Duel.GetDecktopGroup(1-p,3)
	local ct=g:GetCount()
	if ct>0 then
		Duel.Hint(HINT_SELECTMSG,p,aux.Stringid(52263685,0))
		local sg=g:Select(p,1,1,nil)
		Duel.MoveSequence(sg:GetFirst(),SEQ_DECKBOTTOM)
		Duel.ConfirmCards(1-p,sg)
		Duel.SortDecktop(p,1-p,ct-1)
		Duel.ConfirmDecktop(1-p,ct-1)
	end
end
