--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 相位精灵  (ID: 60292055)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Cyberse
-- ATK 2000 | LINK
--
-- Effect Text:
-- 3星以上的电子界族怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升这张卡所连接区的怪兽数量×300。
-- ②：连接召唤的表侧表示的这张卡从场上离开的场合，以自己墓地1只4星以下的电子界族怪兽为对象才能发动。那只怪兽特殊召唤。这个效果特殊召唤的怪兽在这个回合效果无效化，不能作为连接素材。
--[[ __CARD_HEADER_END__ ]]

--エルフェーズ
function c60292055.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c60292055.mfilter,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c60292055.atkval)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(60292055,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,60292055)
	e2:SetCondition(c60292055.spcon)
	e2:SetTarget(c60292055.sptg)
	e2:SetOperation(c60292055.spop)
	c:RegisterEffect(e2)
end
function c60292055.mfilter(c)
	return c:IsLevelAbove(3) and c:IsLinkRace(RACE_CYBERSE)
end
function c60292055.atkval(e,c)
	return c:GetLinkedGroupCount()*300
end
function c60292055.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_LINK) and c:IsPreviousPosition(POS_FACEUP)
end
function c60292055.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsRace(RACE_CYBERSE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c60292055.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c60292055.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c60292055.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c60292055.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c60292055.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
		e3:SetValue(1)
		tc:RegisterEffect(e3)
	end
	Duel.SpecialSummonComplete()
end
