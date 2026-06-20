--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 无形阵·假面  (ID: 23160024)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：场上的「无形噬体」怪兽的攻击力·守备力上升300。
-- ②：只要这张卡在场地区域存在，每次自己场上的「无形噬体」怪兽被解放让自己从卡组抽1张。这个效果1回合可以适用最多2次。
-- ③：把墓地的这张卡除外才能发动。从自己的手卡·场上把等级合计直到8的灵摆怪兽解放，从手卡把「虚龙魔王 无形矢·心灵」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--アモルファスP
function c23160024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0xe0))
	e2:SetValue(300)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--draw
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_RELEASE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(2)
	e4:SetCondition(c23160024.drcon)
	e4:SetOperation(c23160024.drop)
	c:RegisterEffect(e4)
	--ritural
	local e5=aux.AddRitualProcEqualCode(c,98287529,nil,nil,c23160024.mfilter,true)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetCode(0)
	e5:SetRange(LOCATION_GRAVE)
	e5:SetCost(aux.bfgcost)
	c:RegisterEffect(e5)
end
function c23160024.cfilter(c,tp)
	return c:IsPreviousSetCard(0xe0) and c:IsReason(REASON_RELEASE) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
end
function c23160024.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c23160024.cfilter,1,nil,tp)
end
function c23160024.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,e:GetHandler():GetCode())
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c23160024.mfilter(c)
	return c:IsType(TYPE_PENDULUM)
end
