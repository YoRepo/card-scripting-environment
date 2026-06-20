--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 圣神兽 塞勒凯特  (ID: 23804920)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Fairy
-- Level 6
-- ATK 3000 | DEF 2000
-- Setcode: 455
--
-- Effect Text:
-- 「塞勒凯特」怪兽＋攻击力2500以下的怪兽
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤的场合或者这张卡和对方怪兽进行战斗的伤害步骤开始时，以对方的场上（表侧表示）·墓地1只怪兽为对象才能发动。那只怪兽除外，这张卡的攻击力上升除外的怪兽的原本攻击力一半数值。
-- ②：只要10星以上的怪兽除外中，这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--聖神獣セルケト
local s,id,o=GetID()
function s.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x1c7),aux.FilterBoolFunction(Card.IsAttackBelow,2500),true)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.atktg)
	e1:SetOperation(s.atkop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.atkcon)
	e2:SetTarget(s.atktg)
	e2:SetOperation(s.atkop)
	c:RegisterEffect(e2)
	--extra attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetCondition(s.eacon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function s.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceupEx() and c:IsAbleToRemove()
end
function s.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	return tc and tc:IsControler(1-tp)
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) end
	if chk==0 then return Duel.IsExistingTarget(s.atkfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=aux.SelectTargetFromFieldFirst(tp,s.atkfilter,tp,0,LOCATION_MZONE+LOCATION_GRAVE,1,1,c)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and aux.NecroValleyFilter()(tc) and tc:IsType(TYPE_MONSTER)
		and tc:IsRelateToChain() and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0
		and (tc:IsLocation(LOCATION_REMOVED) or tc:IsType(TYPE_TOKEN))
		and c:IsRelateToChain() and c:IsFaceup() then
		local upval=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(upval/2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function s.eacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceup,Card.IsLevelAbove),0,LOCATION_REMOVED,LOCATION_REMOVED,1,nil,10)
end
