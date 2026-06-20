--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 青眼喷气龙  (ID: 30576089)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 0
-- Setcode: 221
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次，若非自己的场上或墓地有「青眼白龙」存在的场合则不能发动。
-- ①：这张卡在手卡·墓地存在，场上的卡被战斗·效果破坏的场合才能发动。这张卡特殊召唤。
-- ②：只要这张卡在怪兽区域存在，自己场上的其他卡不会被对方的效果破坏。
-- ③：这张卡进行战斗的伤害步骤开始时，以对方场上1张卡为对象才能发动。那张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--ブルーアイズ・ジェット・ドラゴン
function c30576089.initial_effect(c)
	aux.AddCodeList(c,89631139)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30576089,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,30576089)
	e1:SetCondition(c30576089.spcon)
	e1:SetTarget(c30576089.sptg)
	e1:SetOperation(c30576089.spop)
	c:RegisterEffect(e1)
	--indestructable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetTarget(c30576089.indtg)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30576089,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_START)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1,30576090)
	e3:SetCondition(c30576089.condition)
	e3:SetTarget(c30576089.thtg)
	e3:SetOperation(c30576089.thop)
	c:RegisterEffect(e3)
end
function c30576089.cfilter(c)
	return (c:IsFaceup() or c:IsLocation(LOCATION_GRAVE)) and c:IsCode(89631139)
end
function c30576089.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c30576089.cfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil)
end
function c30576089.spfilter(c)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c30576089.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c30576089.condition(e,tp,eg,ep,ev,re,r,rp) and eg:IsExists(c30576089.spfilter,1,nil) and (not eg:IsContains(c) or c:IsLocation(LOCATION_HAND))
end
function c30576089.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c30576089.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c30576089.indtg(e,c)
	return c~=e:GetHandler()
end
function c30576089.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c30576089.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
