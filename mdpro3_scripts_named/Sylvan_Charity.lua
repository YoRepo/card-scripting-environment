--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 森罗的施舍  (ID: 82016179)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 144
--
-- Effect Text:
-- 从卡组抽3张卡。那之后，把包含1张名字带有「森罗」的卡的手卡2张卡给对方观看，用喜欢的顺序回到卡组上面。手卡没有名字带有「森罗」的卡的场合，手卡全部给对方观看，用喜欢的顺序回到卡组上面。「森罗的施舍」
-- 在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--森羅の施し
function c82016179.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,82016179+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c82016179.target)
	e1:SetOperation(c82016179.activate)
	c:RegisterEffect(e1)
end
function c82016179.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(3)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,3)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,0,tp,2)
end
function c82016179.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)==3 then
		Duel.ShuffleHand(p)
		Duel.BreakEffect()
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,p,LOCATION_HAND,0,nil)
		if g:GetCount()>1 and g:IsExists(Card.IsSetCard,1,nil,0x90) then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
			local sg1=g:FilterSelect(p,Card.IsSetCard,1,1,nil,0x90)
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
			local sg2=g:Select(p,1,1,sg1:GetFirst())
			sg1:Merge(sg2)
			Duel.ConfirmCards(1-p,sg1)
			aux.PlaceCardsOnDeckTop(p,sg1)
		else
			local hg=Duel.GetFieldGroup(p,LOCATION_HAND,0)
			Duel.ConfirmCards(1-p,hg)
			aux.PlaceCardsOnDeckTop(p,hg)
		end
	end
end
