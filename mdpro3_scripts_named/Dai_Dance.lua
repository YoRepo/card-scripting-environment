--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 粗人舞导  (ID: 50696588)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的效果在决斗中只能适用1次。
-- ①：指定没有使用的对方的主要怪兽区域1处才能发动。只要指定的区域是可以使用，对方要在主要怪兽区域把怪兽通常召唤·特殊召唤的场合，不是那个区域不能使用。这个效果直到指定的区域有怪兽被放置为止适用。
--[[ __CARD_HEADER_END__ ]]

--GUYダンス
--not fully implemented (require other cards to be updated)
function c50696588.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c50696588.cost)
	e1:SetTarget(c50696588.target)
	e1:SetOperation(c50696588.activate)
	c:RegisterEffect(e1)
end
function c50696588.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,50696588)==0 end
end
function c50696588.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,PLAYER_NONE,0)>0 end
	local flag=Duel.SelectDisableField(tp,1,0,LOCATION_MZONE,0)
	e:SetLabel(flag)
	Duel.Hint(HINT_ZONE,tp,flag)
end
function c50696588.activate(e,tp,eg,ep,ev,re,r,rp)
	local flag=e:GetLabel()
	local seq=math.log(bit.rshift(flag,16),2)
	if not Duel.CheckLocation(1-tp,LOCATION_MZONE,seq)
		or Duel.GetFlagEffect(tp,50696588)~=0 then return end
	Duel.RegisterFlagEffect(tp,50696588,0,0,0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_MUST_USE_MZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetTargetRange(0,1)
	e1:SetValue(flag | 0x600060)
	e1:SetCountLimit(1)
	Duel.RegisterEffect(e1,tp)
end
