--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 恶魔招来  (ID: 64635042)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2500 | DEF 1200
-- Setcode: 69
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：这张卡只要在怪兽区域存在，卡名当作「恶魔召唤」使用。
-- ②：只要这张卡在怪兽区域存在，对方不能把自己场上的「恶魔召唤」作为效果的对象。
-- ③：同调召唤的这张卡被对方送去墓地的场合才能发动。从自己的手卡·卡组·墓地选1只「恶魔召唤」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--デーモンの招来
function c64635042.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	--code
	aux.EnableChangeCode(c,70781052)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,70781052))
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCondition(c64635042.spcon)
	e3:SetTarget(c64635042.sptg)
	e3:SetOperation(c64635042.spop)
	c:RegisterEffect(e3)
end
function c64635042.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsSummonType(SUMMON_TYPE_SYNCHRO)
		and rp==1-tp and c:IsPreviousControler(tp)
end
function c64635042.spfilter(c,e,tp)
	return c:IsCode(70781052) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c64635042.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c64635042.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c64635042.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c64635042.spfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
