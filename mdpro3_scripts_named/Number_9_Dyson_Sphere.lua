--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: No.9 天盖星 戴森球  (ID: 1992816)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 9
-- ATK 2800 | DEF 3000
-- Setcode: 72
--
-- Effect Text:
-- 9星怪兽×2
-- ①：持有比这张卡高的攻击力的怪兽在对方场上存在的场合，自己主要阶段1把这张卡1个超量素材取除才能发动。这个回合，这张卡可以直接攻击。
-- ②：持有超量素材的这张卡被攻击的战斗步骤才能发动1次。那次攻击无效。
-- ③：这张卡没有超量素材的状态被选择作为攻击对象时，以自己墓地2只怪兽为对象才能发动。那些怪兽在这张卡下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--No.9 天蓋星ダイソン・スフィア
function c1992816.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2)
	c:EnableReviveLimit()
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1992816,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_BATTLE_PHASE)
	e1:SetCondition(c1992816.atkcon)
	e1:SetCost(c1992816.atkcost)
	e1:SetOperation(c1992816.atkop)
	c:RegisterEffect(e1)
	--material
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1992816,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCondition(c1992816.olcon)
	e2:SetTarget(c1992816.oltg)
	e2:SetOperation(c1992816.olop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(1992816,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c1992816.dacon)
	e3:SetCost(c1992816.dacost)
	e3:SetOperation(c1992816.daop)
	c:RegisterEffect(e3)
end
aux.xyz_number[1992816]=9
function c1992816.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and e:GetHandler():GetOverlayCount()~=0
end
function c1992816.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(1992816)==0 end
	e:GetHandler():RegisterFlagEffect(1992816,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c1992816.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c1992816.olcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayCount()==0 and e:GetHandler():IsType(TYPE_XYZ)
end
function c1992816.matfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsCanOverlay()
end
function c1992816.oltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c1992816.matfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1992816.matfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectTarget(tp,c1992816.matfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,2,0,0)
end
function c1992816.olfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsCanOverlay()
end
function c1992816.olop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c1992816.olfilter,nil,e)
		if g:GetCount()>0 then
			Duel.Overlay(c,g)
		end
	end
end
function c1992816.dafilter(c,atk)
	return c:IsFaceup() and c:GetAttack()>atk
end
function c1992816.dacon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
		and Duel.IsExistingMatchingCard(c1992816.dafilter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack())
end
function c1992816.dacost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c1992816.daop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e)
		and Duel.IsExistingMatchingCard(c1992816.dafilter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
