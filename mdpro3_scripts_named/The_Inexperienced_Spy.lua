--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 未熟的密探  (ID: 81820689)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 指定对方的1张手卡进行观看。
--[[ __CARD_HEADER_END__ ]]

--未熟な密偵
function c81820689.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c81820689.cftg)
	e1:SetOperation(c81820689.cfop)
	c:RegisterEffect(e1)
end
function c81820689.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetTargetPlayer(tp)
end
function c81820689.cfop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(p,nil,p,0,LOCATION_HAND,1,1,nil)
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
		Duel.ShuffleHand(1-p)
	end
end
