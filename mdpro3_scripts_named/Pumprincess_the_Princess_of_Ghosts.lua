--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幽灵姬-南瓜公主-  (ID: 17601919)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 900 | DEF 1000
--
-- Effect Text:
-- 这张卡在怪兽卡区域上被破坏的场合，可以不送去墓地当作永续魔法卡使用在自己的魔法与陷阱卡区域表侧表示放置。这个效果当作永续魔法卡使用的场合，每次双方的准备阶段给这张卡放置1个南瓜指示物。对方场上的全部怪
-- 兽的攻击力·守备力下降当作永续魔法卡使用的这张卡放置的南瓜指示物数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--ゴースト姫－パンプリンセス－
function c17601919.initial_effect(c)
	c:EnableCounterPermit(0x2f,LOCATION_SZONE)
	--send replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c17601919.repcon)
	e1:SetOperation(c17601919.repop)
	c:RegisterEffect(e1)
end
function c17601919.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c17601919.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17601919,1))
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetTarget(c17601919.addct)
	e2:SetOperation(c17601919.addc)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e2)
	--addown
	local e3=Effect.CreateEffect(c)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c17601919.adval)
	e3:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
end
function c17601919.addct(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x2f)
end
function c17601919.addc(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x2f,1)
	end
end
function c17601919.adval(e,c)
	return e:GetHandler():GetCounter(0x2f)*-100
end
