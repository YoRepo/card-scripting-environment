--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 提灯鲨  (ID: 70156946)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 4
-- ATK 1500 | DEF 900
-- Setcode: 440
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。从手卡把「提灯鲨」以外的1只3～5星的水属性怪兽守备表示特殊召唤。这个效果的发动后，直到回合结束时自己不是超量怪兽不能从额外卡组特殊召唤。
-- ②：把这张卡在水属性怪兽的超量召唤使用的场合，可以把这张卡的等级当作3星或5星使用。
--[[ __CARD_HEADER_END__ ]]

--ランタン・シャーク
function c70156946.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70156946,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,70156946)
	e1:SetTarget(c70156946.sptg)
	e1:SetOperation(c70156946.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--xyzlv
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_XYZ_LEVEL)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c70156946.xyzlv)
	e3:SetLabel(3)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetLabel(5)
	c:RegisterEffect(e4)
end
function c70156946.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelAbove(3) and c:IsLevelBelow(5) and not c:IsCode(70156946)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c70156946.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c70156946.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c70156946.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c70156946.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c70156946.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c70156946.splimit(e,c)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end
function c70156946.xyzlv(e,c,rc)
	if rc:IsAttribute(ATTRIBUTE_WATER) then
		return c:GetLevel()+0x10000*e:GetLabel()
	else
		return c:GetLevel()
	end
end
