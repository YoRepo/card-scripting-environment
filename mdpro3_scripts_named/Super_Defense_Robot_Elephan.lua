--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超级防卫机器人·象斗士  (ID: 45496268)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 8
-- ATK 1400 | DEF 2500
-- Setcode: 133
--
-- Effect Text:
-- 这张卡召唤成功时，可以从手卡把1只名字带有「超级防卫机器人」的怪兽或者「轨道 7」特殊召唤。1回合1次，选择自己场上1只名字带有「超级防卫机器人」的怪兽或者「轨道
-- 7」才能发动。选择的怪兽的等级直到结束阶段时变成8星。此外，把这张卡作为超量召唤的素材的场合，不是机械族怪兽的超量召唤不能使用。
--[[ __CARD_HEADER_END__ ]]

--SDロボ・エレファン
function c45496268.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45496268,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c45496268.sumtg)
	e1:SetOperation(c45496268.sumop)
	c:RegisterEffect(e1)
	--lvchange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45496268,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c45496268.lvtg)
	e2:SetOperation(c45496268.lvop)
	c:RegisterEffect(e2)
	--xyzlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetValue(c45496268.xyzlimit)
	c:RegisterEffect(e3)
end
function c45496268.filter(c,e,tp)
	return (c:IsSetCard(0x85) or c:IsCode(71071546)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45496268.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c45496268.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c45496268.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c45496268.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c45496268.lvfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x85) or c:IsCode(71071546)) and not c:IsLevel(8) and c:IsLevelAbove(1)
end
function c45496268.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c45496268.lvfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c45496268.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c45496268.lvfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c45496268.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(8)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c45496268.xyzlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_MACHINE)
end
