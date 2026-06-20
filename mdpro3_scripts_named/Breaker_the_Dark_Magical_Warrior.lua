--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 黑魔导战士 破坏者  (ID: 22923081)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 1600 | DEF 1000
-- Setcode: 110
--
-- Effect Text:
-- 「黑魔导战士 破坏者」的④的效果1回合只能使用1次。
-- ①：这张卡召唤成功的场合发动。给这张卡放置2个魔力指示物。
-- ②：这张卡灵摆召唤成功的场合发动。给这张卡放置3个魔力指示物。
-- ③：这张卡的攻击力上升这张卡的魔力指示物数量×400。
-- ④：把这张卡1个魔力指示物取除，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--黒魔導戦士 ブレイカー
function c22923081.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22923081,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c22923081.addtg)
	e1:SetOperation(c22923081.addop)
	e1:SetLabel(2)
	c:RegisterEffect(e1)
	--spsummon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22923081,1))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c22923081.addcon)
	e2:SetTarget(c22923081.addtg)
	e2:SetOperation(c22923081.addop)
	e2:SetLabel(3)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c22923081.atkval)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(22923081,2))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,22923081)
	e4:SetCost(c22923081.descost)
	e4:SetTarget(c22923081.destg)
	e4:SetOperation(c22923081.desop)
	c:RegisterEffect(e4)
end
function c22923081.addtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,e:GetLabel(),0,0x1)
end
function c22923081.addop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1,e:GetLabel())
	end
end
function c22923081.addcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c22923081.atkval(e,c)
	return c:GetCounter(0x1)*400
end
function c22923081.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1,1,REASON_COST)
end
function c22923081.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c22923081.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c22923081.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c22923081.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c22923081.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c22923081.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
