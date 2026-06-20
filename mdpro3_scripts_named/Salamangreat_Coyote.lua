--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 转生炎兽 郊狼  (ID: 71861848)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 3
-- ATK 1000 | DEF 200
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡作为连接素材送去墓地的回合的结束阶段可以从以下效果选择1个发动。
-- ●以「转生炎兽 郊狼」以外的自己墓地1只「转生炎兽」怪兽为对象才能发动。那只怪兽守备表示特殊召唤。
-- ●以「转生炎兽 郊狼」以外的自己墓地1张「转生炎兽」卡为对象才能发动。那张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣コヨーテ
function c71861848.initial_effect(c)
	--register effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetOperation(c71861848.regop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(71861848,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,71861848)
	e2:SetCondition(c71861848.condition)
	e2:SetTarget(c71861848.sptg)
	e2:SetOperation(c71861848.spop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(71861848,1))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,71861848)
	e3:SetCondition(c71861848.condition)
	e3:SetTarget(c71861848.thtg)
	e3:SetOperation(c71861848.thop)
	c:RegisterEffect(e3)
end
function c71861848.regop(e,tp,eg,ep,ev,re,r,rp)
	if r==REASON_LINK then
		e:GetHandler():RegisterFlagEffect(71861848,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c71861848.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(71861848)>0
end
function c71861848.spfilter(c,e,tp)
	return c:IsSetCard(0x119) and not c:IsCode(71861848) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c71861848.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c71861848.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c71861848.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c71861848.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c71861848.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c71861848.thfilter(c)
	return c:IsSetCard(0x119) and c:IsAbleToHand() and not c:IsCode(71861848)
end
function c71861848.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c71861848.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c71861848.thfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c71861848.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c71861848.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
