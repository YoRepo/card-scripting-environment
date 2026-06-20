--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 巨大战舰 晶核  (ID: 22790789)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Machine
-- Level 5
-- ATK 2100 | DEF 1000
-- Setcode: 21
--
-- Effect Text:
-- ①：这张卡召唤的场合发动。给这张卡放置3个指示物。
-- ②：这张卡不会被战斗破坏。
-- ③：1回合1次，以对方场上1只表侧攻击表示怪兽为对象才能发动。那只对方的表侧攻击表示怪兽变成表侧守备表示。
-- ④：这张卡进行战斗的伤害步骤结束时发动。这张卡1个指示物取除。不能取除的场合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--巨大戦艦 クリスタル・コア
function c22790789.initial_effect(c)
	c:EnableCounterPermit(0x1f)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22790789,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c22790789.addct)
	e1:SetOperation(c22790789.addc)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--remove counter
	aux.EnableBESRemove(c)
	--pos
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(22790789,3))
	e5:SetCategory(CATEGORY_POSITION)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c22790789.postg)
	e5:SetOperation(c22790789.posop)
	c:RegisterEffect(e5)
end
function c22790789.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,3,0,0x1f)
end
function c22790789.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1f,3)
	end
end
function c22790789.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c22790789.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c22790789.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c22790789.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c22790789.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c22790789.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsPosition(POS_FACEUP_ATTACK) and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
	end
end
