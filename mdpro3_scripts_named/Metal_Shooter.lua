--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 金属射手  (ID: 7200041)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 5
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 这张卡召唤成功时，给这张卡放置2个指示物。这个效果每放置有1个指示物，这张卡的攻击力上升800。这张卡被其他卡的效果破坏的场合，把这张卡的1个指示物取除作代替。
--[[ __CARD_HEADER_END__ ]]

--メタル・シューター
function c7200041.initial_effect(c)
	c:EnableCounterPermit(0x26)
	--summon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7200041,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c7200041.addct)
	e1:SetOperation(c7200041.addc)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c7200041.attackup)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c7200041.reptg)
	c:RegisterEffect(e3)
end
function c7200041.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x26)
end
function c7200041.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x26,2)
	end
end
function c7200041.attackup(e,c)
	return c:GetCounter(0x26)*800
end
function c7200041.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_EFFECT)
		and e:GetHandler():IsCanRemoveCounter(tp,0x26,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x26,1,REASON_EFFECT)
	return true
end
