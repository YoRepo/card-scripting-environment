--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 年代记魔术师  (ID: 60948488)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 2500 | DEF 2500
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有原本攻击力或者原本守备力是2500的怪兽召唤·特殊召唤的场合才能发动。这张卡从手卡守备表示特殊召唤。
-- ②：这张卡特殊召唤成功的场合，以自己场上1只「黑魔术师」或者「青眼白龙」为对象才能发动。那只怪兽的攻击力·守备力直到回合结束时上升2500。
--[[ __CARD_HEADER_END__ ]]

--クロニクル・マジシャン
function c60948488.initial_effect(c)
	aux.AddCodeList(c,46986414,89631139)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60948488,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,60948488)
	e1:SetCondition(c60948488.spcon)
	e1:SetTarget(c60948488.sptg)
	e1:SetOperation(c60948488.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(60948488,1))
	e3:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCountLimit(1,60948489)
	e3:SetTarget(c60948488.atktg)
	e3:SetOperation(c60948488.atkop)
	c:RegisterEffect(e3)
end
function c60948488.cfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
		and (c:GetBaseAttack()==2500 or c:GetBaseDefense()==2500)
end
function c60948488.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60948488.cfilter,1,nil,tp)
end
function c60948488.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c60948488.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
function c60948488.atkfilter(c)
	return c:IsFaceup() and c:IsCode(46986414,89631139)
end
function c60948488.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp)
		and c60948488.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c60948488.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c60948488.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c60948488.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(2500)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
