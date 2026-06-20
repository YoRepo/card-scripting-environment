--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 威迫矿石-迫选召唤石  (ID: 91592030)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以自己墓地3只怪兽为对象才能发动。自己从那3只之中选1只。那之后，对方从以下效果选1个，自己让那个效果适用。
-- ●选的怪兽特殊召唤。
-- ●选的怪兽以外的作为对象的怪兽尽可能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--威迫鉱石－サモナイト
function c91592030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c91592030.target)
	e1:SetOperation(c91592030.activate)
	c:RegisterEffect(e1)
end
function c91592030.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c91592030.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c91592030.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c91592030.filter,tp,LOCATION_GRAVE,0,3,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c91592030.filter,tp,LOCATION_GRAVE,0,3,3,nil,e,tp)
end
function c91592030.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetTargetsRelateToChain()
	if #g~=3 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local sg=g:Select(tp,1,1,nil)
	Duel.HintSelection(sg)
	g:RemoveCard(sg:GetFirst())
	local opt=Duel.SelectOption(1-tp,aux.Stringid(91592030,0),aux.Stringid(91592030,1))
	if opt==0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	else
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		if ft>0 then
			local sg2=g
			if ft<#g then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				sg2=g:Select(tp,ft,ft,nil)
			end
			Duel.SpecialSummon(sg2,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
