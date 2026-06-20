--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 紫炎的荒武者  (ID: 98162021)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1600 | DEF 1000
-- Setcode: 32
--
-- Effect Text:
-- 这张卡召唤成功时，给这张卡放置1个武士道指示物（最多1个）。这张卡有武士道指示物放置的场合，这张卡的攻击力上升300。此外，1回合1次，可以把这张卡放置的武士道指示物取除，并选择场上表侧表示存在的1张
-- 可以放置武士道指示物的卡放置1个武士道指示物。
--[[ __CARD_HEADER_END__ ]]

--紫炎の荒武者
function c98162021.initial_effect(c)
	c:EnableCounterPermit(0x3)
	c:SetCounterLimit(0x3,1)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98162021,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c98162021.addct)
	e1:SetOperation(c98162021.addc)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c98162021.attackup)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98162021,0))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c98162021.addct2)
	e3:SetOperation(c98162021.addc2)
	c:RegisterEffect(e3)
end
c98162021.counter_add_list={0x3}
function c98162021.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x3)
end
function c98162021.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x3,1)
	end
end
function c98162021.attackup(e,c)
	return c:GetCounter(0x3)*300
end
function c98162021.addct2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsCanAddCounter(0x3,1) end
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x3,1,REASON_EFFECT)
		and Duel.IsExistingTarget(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler(),0x3,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
	Duel.SelectTarget(tp,Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler(),0x3,1)
end
function c98162021.addc2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetCounter(0x3)==0 then return end
	c:RemoveCounter(tp,0x3,1,REASON_EFFECT)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x3,1)
	end
end
