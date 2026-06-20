--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 卡片守卫  (ID: 4694209)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1600 | DEF 500
--
-- Effect Text:
-- 这张卡召唤·特殊召唤成功时，给这张卡放置1个守卫指示物。这张卡放置的守卫指示物每有1个，这张卡的攻击力上升300。此外，1回合1次，可以把这张卡放置的1个守卫指示物取除，并给这张卡以外的自己场上表侧表
-- 示存在的1张卡放置1个守卫指示物。选择的卡被破坏的场合，作为代替把1个守卫指示物取除。
--[[ __CARD_HEADER_END__ ]]

--カードガード
function c4694209.initial_effect(c)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4694209,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c4694209.addct)
	e1:SetOperation(c4694209.addc)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--attackup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c4694209.attackup)
	c:RegisterEffect(e3)
	--destroy rep
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4694209,1))
	e4:SetCategory(CATEGORY_COUNTER)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCost(c4694209.addccost2)
	e4:SetTarget(c4694209.addct2)
	e4:SetOperation(c4694209.addc2)
	c:RegisterEffect(e4)
end
function c4694209.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x1021)
end
function c4694209.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x1021,1)
	end
end
function c4694209.attackup(e,c)
	return c:GetCounter(0x1021)*300
end
function c4694209.addccost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x1021,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x1021,1,REASON_COST)
end
function c4694209.addct2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc:IsCanAddCounter(0x1021,1) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,0,1,e:GetHandler(),0x1021,1) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(4694209,1))
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler(),0x1021,1)
end
function c4694209.addc2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x1021,1)
		if tc:GetFlagEffect(4694209)~=0 then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EFFECT_DESTROY_REPLACE)
		e1:SetTarget(c4694209.reptg)
		e1:SetOperation(c4694209.repop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(4694209,RESET_EVENT+RESETS_STANDARD,0,0)
	end
end
function c4694209.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsReason(REASON_RULE) and e:GetHandler():GetCounter(0x1021)>0 end
	return true
end
function c4694209.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x1021,1,REASON_EFFECT)
end
