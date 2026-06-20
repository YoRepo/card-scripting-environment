--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 野鸭战斗机  (ID: 54813225)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level 3
-- ATK 1300 | DEF 1400
--
-- Effect Text:
-- 把自己场上的衍生物那个等级合计直到3以上解放才能发动。这张卡从手卡或者墓地特殊召唤。「野鸭战斗机」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ダックファイター
function c54813225.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54813225,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,54813225)
	e1:SetCost(c54813225.spcost)
	e1:SetTarget(c54813225.sptg)
	e1:SetOperation(c54813225.spop)
	c:RegisterEffect(e1)
end
function c54813225.relgoal(sg,tp)
	Duel.SetSelectedCard(sg)
	return sg:CheckWithSumGreater(Card.GetLevel,3) and aux.mzctcheckrel(sg,tp)
end
function c54813225.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetReleaseGroup(tp):Filter(Card.IsType,nil,TYPE_TOKEN)
	if chk==0 then return mg:CheckSubGroup(c54813225.relgoal,1,3,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=mg:SelectSubGroup(tp,c54813225.relgoal,false,1,3,tp)
	aux.UseExtraReleaseCount(sg,tp)
	Duel.Release(sg,REASON_COST)
end
function c54813225.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c54813225.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
