--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 娱乐伙伴 五虹之魔术师  (ID: 19619755)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 1
-- Pendulum Scales: L12 / R12
-- ATK 100 | DEF 100
-- Setcode: 9961631
--
-- Effect Text:
-- ←12 【灵摆】 12→
-- ①：自己不是从额外卡组中不能灵摆召唤。这个效果不会被无效化。
-- ②：双方受自身的魔法与陷阱区域盖放的卡数量对应的以下所适用。
-- ●0张：自己场上的怪兽不能攻击并不能把效果发动。
-- ●4张以上：自己场上的怪兽的攻击力变成原本数值的2倍。
-- 【怪兽效果】
-- ①：这张卡在墓地存在，自己场上有魔法·陷阱卡被盖放的场合才能发动。墓地的这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--EM五虹の魔術師
function c19619755.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--scale
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SSET)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c19619755.pencon)
	e1:SetTarget(c19619755.pentg)
	e1:SetOperation(c19619755.penop)
	c:RegisterEffect(e1)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c19619755.splimit)
	c:RegisterEffect(e2)
	--prevent attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_PZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c19619755.atktg)
	c:RegisterEffect(e3)
	--act limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_PZONE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c19619755.limval)
	c:RegisterEffect(e4)
	--double atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SET_ATTACK)
	e5:SetRange(LOCATION_PZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetCondition(c19619755.atkcon0)
	e5:SetValue(c19619755.atkval)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetTargetRange(0,LOCATION_MZONE)
	e6:SetCondition(c19619755.atkcon1)
	c:RegisterEffect(e6)
end
function c19619755.pencon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,tp)
end
function c19619755.pentg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,e:GetHandler(),1,0,0)
end
function c19619755.penop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_PZONE,POS_FACEUP,true)
	end
end
function c19619755.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM and not c:IsLocation(LOCATION_EXTRA)
end
function c19619755.countfilter(c)
	return c:IsFacedown() and c:GetSequence()<5
end
function c19619755.atktg(e,c)
	local tp=c:GetControler()
	return Duel.GetMatchingGroupCount(c19619755.countfilter,tp,LOCATION_SZONE,0,nil)==0
end
function c19619755.limval(e,re,rp)
	local rc=re:GetHandler()
	local tp=rc:GetControler()
	return rc:IsLocation(LOCATION_MZONE) and re:IsActiveType(TYPE_MONSTER)
		and Duel.GetMatchingGroupCount(c19619755.countfilter,tp,LOCATION_SZONE,0,nil)==0
end
function c19619755.atkcon0(e)
	return Duel.GetMatchingGroupCount(c19619755.countfilter,e:GetHandlerPlayer(),LOCATION_SZONE,0,nil)>=4
end
function c19619755.atkcon1(e)
	return Duel.GetMatchingGroupCount(c19619755.countfilter,e:GetHandlerPlayer(),0,LOCATION_SZONE,nil)>=4
end
function c19619755.atkval(e,c)
	return c:GetBaseAttack()*2
end
