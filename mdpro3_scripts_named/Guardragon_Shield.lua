--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 守护龙的结界  (ID: 50186558)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：以自己场上1只龙族怪兽为对象才能发动。那只怪兽的攻击力·守备力直到对方回合结束时上升场上的连接怪兽的连接标记合计×100。
-- ②：1回合1次，只让自己场上的龙族怪兽1只被战斗·效果破坏的场合，可以作为代替从手卡·卡组把1只通常怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--守護竜の結界
function c50186558.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50186558,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,50186558)
	e2:SetTarget(c50186558.atktg)
	e2:SetOperation(c50186558.atkop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c50186558.desreptg)
	e3:SetValue(c50186558.desrepval)
	e3:SetOperation(c50186558.desrepop)
	c:RegisterEffect(e3)
end
function c50186558.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c50186558.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c50186558.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c50186558.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50186558.atkfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c50186558.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c50186558.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c50186558.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c50186558.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=g:GetSum(Card.GetLink)
	local tc=Duel.GetFirstTarget()
	if ct>0 and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c50186558.repfilter(c,tp)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsRace(RACE_DRAGON) and c:IsControler(tp)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c50186558.tgfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToGrave()
end
function c50186558.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:GetCount()==1 and eg:IsExists(c50186558.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c50186558.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c50186558.desrepval(e,c)
	return c50186558.repfilter(c,e:GetHandlerPlayer())
end
function c50186558.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c50186558.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
