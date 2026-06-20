--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 镜之御巫 迩迩  (ID: 54862960)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Spellcaster
-- Level 3
-- ATK 0 | DEF 0
-- Setcode: 397
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡没有装备卡装备的场合，这张卡的战斗发生的对自己的战斗伤害变成0，有装备的场合，这张卡不会被战斗破坏，这张卡的战斗发生的对自己的战斗伤害由对方代受。
-- ②：对方回合，这张卡有装备卡装备的场合，以对方场上1只表侧表示怪兽为对象才能发动。那只怪兽的控制权直到结束阶段得到。
--[[ __CARD_HEADER_END__ ]]

--鏡の御巫ニニ
function c54862960.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c54862960.ndcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	e2:SetCondition(c54862960.indcon)
	c:RegisterEffect(e2)
	--reflect battle damage
	local e3=e2:Clone()
	e3:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	c:RegisterEffect(e3)
	--control
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_CONTROL)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e4:SetCountLimit(1,54862960)
	e4:SetCondition(c54862960.ctcon)
	e4:SetTarget(c54862960.cttg)
	e4:SetOperation(c54862960.ctop)
	c:RegisterEffect(e4)
end
function c54862960.ndcon(e)
	return e:GetHandler():GetEquipCount()==0
end
function c54862960.indcon(e)
	return e:GetHandler():GetEquipCount()>0
end
function c54862960.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipCount()>0 and Duel.GetTurnPlayer()==1-tp
end
function c54862960.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c54862960.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c54862960.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54862960.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c54862960.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c54862960.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
