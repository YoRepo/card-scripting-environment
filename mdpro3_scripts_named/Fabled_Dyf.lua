--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 魔轰神 迪夫  (ID: 86840720)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level 3
-- ATK 1400 | DEF 1700
-- Setcode: 53
--
-- Effect Text:
-- 名字带有「魔轰神」的怪兽从手卡送去自己墓地时，把自己场上存在的这张卡解放，选择那1只怪兽才能发动。选择怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔轟神ディフ
function c86840720.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86840720,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c86840720.spcost)
	e1:SetTarget(c86840720.sptg)
	e1:SetOperation(c86840720.spop)
	c:RegisterEffect(e1)
end
function c86840720.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c86840720.filter(c,e,tp)
	return c:IsSetCard(0x35) and c:IsPreviousLocation(LOCATION_HAND) and c:IsControler(tp)
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c86840720.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c86840720.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and eg:IsExists(c86840720.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=eg:FilterSelect(tp,c86840720.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c86840720.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
