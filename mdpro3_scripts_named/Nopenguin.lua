--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 否定企鹅  (ID: 32623004)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 1600 | DEF 100
-- Setcode: 90
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，「企鹅」卡的效果从场上回到手卡的卡不回到手卡而除外。
-- ②：这张卡在墓地存在，「企鹅」怪兽的效果发动时发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--否定ペンギン
function c32623004.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32623004,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,32623004)
	e1:SetCondition(c32623004.spcon)
	e1:SetTarget(c32623004.sptg)
	e1:SetOperation(c32623004.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_TO_HAND_REDIRECT)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c32623004.rmtg)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end
function c32623004.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x5a)
end
function c32623004.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c32623004.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c32623004.rmtg(e,c)
	return c:IsReason(REASON_EFFECT) and c:GetReasonEffect():GetHandler():IsSetCard(0x5a)
end
