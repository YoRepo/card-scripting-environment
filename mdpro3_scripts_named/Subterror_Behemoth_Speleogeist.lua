--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 地中族邪界兽·埃琴磁魔神  (ID: 47556396)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Fiend
-- Level 11
-- ATK 3000 | DEF 1400
-- Setcode: 4333
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：自己场上的表侧表示怪兽变成里侧表示时，自己场上没有表侧表示怪兽存在的场合才能发动。这张卡从手卡守备表示特殊召唤。
-- ②：自己主要阶段才能发动。这张卡变成里侧守备表示（1回合只有1次）。
-- ③：这张卡反转的场合，以场上1只怪兽为对象才能发动。那只怪兽是守备表示的场合，变成表侧攻击表示。那只怪兽的攻击力变成0。
--[[ __CARD_HEADER_END__ ]]

--サブテラーマリス・エルガウスト
function c47556396.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(47556396,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,47556396)
	e1:SetTarget(c47556396.target)
	e1:SetOperation(c47556396.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47556396,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_HAND)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetCondition(c47556396.spcon)
	e2:SetTarget(c47556396.sptg)
	e2:SetOperation(c47556396.spop)
	c:RegisterEffect(e2)
	--turn set
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(47556396,2))
	e3:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c47556396.postg)
	e3:SetOperation(c47556396.posop)
	c:RegisterEffect(e3)
end
function c47556396.filter(c)
	return c:IsDefensePos() or c:GetAttack()>0
end
function c47556396.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c47556396.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c47556396.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c47556396.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c47556396.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	if tc:IsDefensePos() then
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
	end
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
function c47556396.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsFacedown() and c:IsControler(tp)
end
function c47556396.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c47556396.cfilter,1,nil,tp)
		and not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
end
function c47556396.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c47556396.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
end
function c47556396.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(47556396)==0 end
	c:RegisterFlagEffect(47556396,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c47556396.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
