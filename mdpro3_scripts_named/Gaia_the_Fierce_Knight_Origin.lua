--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 暗黑骑士 盖亚本源  (ID: 50354944)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1200
-- Setcode: 189
--
-- Effect Text:
-- 这个卡名的①③的效果1回合各能使用1次。
-- ①：从手卡把1只5星以上的怪兽送去墓地才能发动。这张卡从手卡特殊召唤。
-- ②：战士族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。
-- ③：自己·对方的战斗阶段，把墓地的这张卡除外，以持有和原本攻击力不同攻击力的场上1只怪兽为对象才能发动。那只怪兽的攻击力变成原本数值。
--[[ __CARD_HEADER_END__ ]]

--暗黒騎士ガイアオリジン
function c50354944.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50354944,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,50354944)
	e1:SetCost(c50354944.spcost)
	e1:SetTarget(c50354944.sptg)
	e1:SetOperation(c50354944.spop)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c50354944.condition)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(50354944,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetHintTiming(TIMING_DAMAGE_STEP)
	e3:SetCountLimit(1,50354945)
	e3:SetCondition(c50354944.atkcon)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c50354944.atktg)
	e3:SetOperation(c50354944.atkop)
	c:RegisterEffect(e3)
end
function c50354944.cfilter(c)
	return c:IsLevelAbove(5) and c:IsAbleToGraveAsCost()
end
function c50354944.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50354944.cfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c50354944.cfilter,tp,LOCATION_HAND,0,1,1,e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST)
end
function c50354944.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c50354944.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c50354944.condition(e,c)
	return c:IsRace(RACE_WARRIOR)
end
function c50354944.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE and aux.dscon(e,tp,eg,ep,ev,re,r,rp)
end
function c50354944.atkfilter(c)
	return c:IsFaceup() and not c:IsAttack(c:GetBaseAttack())
end
function c50354944.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c50354944.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50354944.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c50354944.atkfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c50354944.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local atk=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
