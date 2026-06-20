--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 超念力枪手/爆裂体  (ID: 37169670)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: EARTH
-- Race: Psychic
-- Level 11
-- ATK 3500 | DEF 3000
-- Setcode: 4175
--
-- Effect Text:
-- 这张卡不能通常召唤。「爆裂模式」的效果才能特殊召唤。这张卡进行战斗的场合，伤害步骤结束时给与对方基本分对方怪兽的守备力数值的伤害，自己基本分回复那只怪兽的攻击力的数值。此外，场上存在的这张卡被破坏时，
-- 可以把自己墓地存在的1只「超念力枪手」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ハイパーサイコガンナー／バスター
function c37169670.initial_effect(c)
	aux.AddCodeList(c,80280737)
	c:EnableReviveLimit()
	--Cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.AssaultModeLimit)
	c:RegisterEffect(e1)
	--damage&recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37169670,0))
	e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c37169670.damcon)
	e2:SetTarget(c37169670.damtg)
	e2:SetOperation(c37169670.damop)
	c:RegisterEffect(e2)
	--Special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(37169670,1))
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c37169670.spcon)
	e3:SetTarget(c37169670.sptg)
	e3:SetOperation(c37169670.spop)
	c:RegisterEffect(e3)
end
c37169670.assault_name=95526884
function c37169670.damcon(e,tp,eg,ep,ev,re,r,rp)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and Duel.GetAttackTarget()~=nil
end
function c37169670.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,d:GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,d:GetAttack())
end
function c37169670.damop(e,tp,eg,ep,ev,re,r,rp)
	local ex1,a1,b1,p1,d1=Duel.GetOperationInfo(0,CATEGORY_DAMAGE)
	local ex2,a2,b2,p2,d2=Duel.GetOperationInfo(0,CATEGORY_RECOVER)
	Duel.Damage(1-tp,d1,REASON_EFFECT,true)
	Duel.Recover(tp,d2,REASON_EFFECT,true)
	Duel.RDComplete()
end
function c37169670.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c37169670.spfilter(c,e,tp)
	return c:IsCode(95526884) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c37169670.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c37169670.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c37169670.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c37169670.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c37169670.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
