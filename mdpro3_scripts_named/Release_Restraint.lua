--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 拘束解除  (ID: 75417459)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：把自己场上1只「铁骑士 基亚·弗里德」解放才能发动。从手卡·卡组把1只「剑圣-赤膊的基亚·弗里德」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--拘束解除
function c75417459.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c75417459.cost)
	e1:SetTarget(c75417459.target)
	e1:SetOperation(c75417459.activate)
	c:RegisterEffect(e1)
end
function c75417459.costfilter(c,tp)
	return c:IsCode(423705)
		and Duel.GetMZoneCount(tp,c)>0 and (c:IsControler(tp) or c:IsFaceup())
end
function c75417459.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c75417459.costfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c75417459.costfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c75417459.filter(c,e,tp)
	return c:IsCode(57046845) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c75417459.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==1 or Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then
		e:SetLabel(0)
		return res and Duel.IsExistingMatchingCard(c75417459.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c75417459.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c75417459.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)>0 then
		g:GetFirst():CompleteProcedure()
	end
end
