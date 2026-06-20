--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 轻盈水星  (ID: 3912064)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 8
-- ATK 2000 | DEF 2000
--
-- Effect Text:
-- ①：这张卡上级召唤成功时才能发动。场上的怪兽全部变成表侧攻击表示。
-- ②：这张卡也能把3只怪兽解放作召唤。
-- ③：只要这张卡的②的方法召唤的这张卡在怪兽区域存在，对方场上的怪兽的攻击力下降那怪兽的原本攻击力数值。
-- ④：这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--The tripping MERCURY
function c3912064.initial_effect(c)
	--change position
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c3912064.poscon)
	e1:SetTarget(c3912064.postg)
	e1:SetOperation(c3912064.posop)
	c:RegisterEffect(e1)
	--summon with 3 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3912064,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c3912064.ttcon)
	e2:SetOperation(c3912064.ttop)
	e2:SetValue(SUMMON_TYPE_ADVANCE+SUMMON_VALUE_SELF)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c3912064.atkcon)
	e3:SetValue(c3912064.atkval)
	c:RegisterEffect(e3)
	--extra attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c3912064.posfilter(c)
	return c:IsDefensePos() or c:IsFacedown()
end
function c3912064.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c3912064.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3912064.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c3912064.posop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c3912064.posfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	Duel.ChangePosition(g,POS_FACEUP_ATTACK)
end
function c3912064.ttcon(e,c,minc)
	if c==nil then return true end
	return minc<=3 and Duel.CheckTribute(c,3)
end
function c3912064.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c3912064.atkcon(e)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+SUMMON_VALUE_SELF
end
function c3912064.atkval(e,c)
	local rec=c:GetBaseAttack()
	if rec<0 then rec=0 end
	return rec*-1
end
