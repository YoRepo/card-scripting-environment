--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 龙星的气脉  (ID: 43577607)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 158
--
-- Effect Text:
-- ①：得到自己墓地的「龙星」怪兽的属性种类数量的以下效果。
-- ●2种类以上：自己场上的「龙星」怪兽的攻击力上升500。
-- ●3种类以上：自己场上的「龙星」怪兽被战斗·效果破坏的场合，可以作为代替把这张卡送去墓地。
-- ●4种类以上：对方不能把怪兽盖放，对方场上的表侧表示怪兽全部变成攻击表示。
-- ●5种类以上：把这张卡送去墓地才能发动。场上的卡全部破坏。
--[[ __CARD_HEADER_END__ ]]

--竜星の気脈
function c43577607.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c43577607.atktg)
	e2:SetValue(500)
	e2:SetCondition(c43577607.effcon)
	e2:SetLabel(2)
	c:RegisterEffect(e2)
	--replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c43577607.reptg)
	e3:SetValue(c43577607.repval)
	e3:SetOperation(c43577607.repop)
	e3:SetCondition(c43577607.effcon)
	e3:SetLabel(3)
	c:RegisterEffect(e3)
	--cannot mset
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_MSET)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,1)
	e4:SetCondition(c43577607.effcon)
	e4:SetLabel(4)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_LIMIT_SPECIAL_SUMMON_POSITION)
	e5:SetTarget(c43577607.sumlimit)
	c:RegisterEffect(e5)
	--poschange
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SET_POSITION)
	e6:SetRange(LOCATION_SZONE)
	e6:SetTargetRange(0,LOCATION_MZONE)
	e6:SetValue(POS_FACEUP_ATTACK)
	e6:SetCondition(c43577607.effcon)
	e6:SetLabel(4)
	c:RegisterEffect(e6)
	--destroy
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(43577607,0))
	e7:SetCategory(CATEGORY_DESTROY)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCondition(c43577607.effcon)
	e7:SetCost(c43577607.descost)
	e7:SetTarget(c43577607.destg)
	e7:SetOperation(c43577607.desop)
	e7:SetLabel(5)
	c:RegisterEffect(e7)
end
function c43577607.confilter(c)
	return c:IsSetCard(0x9e) and c:IsType(TYPE_MONSTER)
end
function c43577607.effcon(e)
	local g=Duel.GetMatchingGroup(c43577607.confilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)
	return g:GetClassCount(Card.GetAttribute)>=e:GetLabel()
end
function c43577607.atktg(e,c)
	return c:IsSetCard(0x9e)
end
function c43577607.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x9e) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c43577607.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_DESTROY_CONFIRMED)
		and eg:IsExists(c43577607.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c43577607.repval(e,c)
	return c43577607.repfilter(c,e:GetHandlerPlayer())
end
function c43577607.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
function c43577607.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return (sumpos&POS_FACEDOWN)>0
end
function c43577607.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c43577607.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c43577607.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
