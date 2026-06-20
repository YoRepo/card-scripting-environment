--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 异次元的指名者  (ID: 33423043)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 宣言1张卡的名称。确认对方手卡，若被宣言的卡在对方手卡中存在，则将其中1张被宣言的卡从游戏中除外；若被宣言的卡未在对方手卡中存在，则自己随机从游戏中除外1张手卡。
--[[ __CARD_HEADER_END__ ]]

--異次元の指名者
function c33423043.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetTarget(c33423043.target)
	e1:SetOperation(c33423043.operation)
	c:RegisterEffect(e1)
end
function c33423043.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		and Duel.IsExistingMatchingCard(nil,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CODE)
	getmetatable(e:GetHandler()).announce_filter={TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK,OPCODE_ISTYPE,OPCODE_NOT}
	local ac=Duel.AnnounceCard(tp,table.unpack(getmetatable(e:GetHandler()).announce_filter))
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,0)
end
function c33423043.operation(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_HAND,nil,ac)
	local hg=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	Duel.ConfirmCards(tp,hg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	else
		local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		local dg=sg:RandomSelect(tp,1)
		Duel.Remove(dg,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
