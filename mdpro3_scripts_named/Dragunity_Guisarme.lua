--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 龙骑兵团-长钩刀龙  (ID: 69975751)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level 3
-- ATK 600 | DEF 1600
-- Setcode: 41
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤成功时，以自己墓地的风属性·4星以下的1只龙族或者鸟兽族的怪兽为对象才能发动。那只怪兽特殊召唤。这个效果特殊召唤的怪兽的效果无效化。
-- ②：这张卡当作装备卡使用而装备中的场合才能发动。装备的这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－ギザーム
function c69975751.initial_effect(c)
	--special summon(graveyard)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69975751,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,69975751)
	e1:SetTarget(c69975751.sptg)
	e1:SetOperation(c69975751.spop)
	c:RegisterEffect(e1)
	--special summon(self)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69975751,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,69975752)
	e2:SetTarget(c69975751.sptg2)
	e2:SetOperation(c69975751.spop2)
	c:RegisterEffect(e2)
end
function c69975751.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WIND) and c:IsLevelBelow(4) and c:IsRace(RACE_DRAGON+RACE_WINDBEAST) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c69975751.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c69975751.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c69975751.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c69975751.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c69975751.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
function c69975751.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:GetEquipTarget() and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c69975751.spop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
