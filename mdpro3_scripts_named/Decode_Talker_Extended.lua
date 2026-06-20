--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 解码语者·扩展  (ID: 30822527)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 2300 | LINK
-- Setcode: 257
--
-- Effect Text:
-- 效果怪兽2只以上
-- ①：这张卡只要在怪兽区域存在，卡名当作「解码语者」使用。
-- ②：这张卡的攻击力上升这张卡所连接区的怪兽数量×500。
-- ③：自己战斗阶段，这张卡所连接区的怪兽被战斗破坏的场合或者被送去墓地的场合才能发动。这个回合，这张卡在同1次的战斗阶段中可以作2次攻击。
--[[ __CARD_HEADER_END__ ]]

--デコード・トーカー・エクステンド
function c30822527.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2)
	--Change Name
	aux.EnableChangeCode(c,1861629)
	--Atk Up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c30822527.atkval)
	c:RegisterEffect(e2)
	--Double Attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c30822527.regcon)
	e3:SetOperation(c30822527.regop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetCondition(c30822527.regcon2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(30822527,0))
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_CUSTOM+30822527)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c30822527.atkcon)
	e5:SetTarget(c30822527.atktg)
	e5:SetOperation(c30822527.atkop)
	c:RegisterEffect(e5)
end
function c30822527.atkval(e,c)
	return c:GetLinkedGroupCount()*500
end
function c30822527.cfilter(c,tp,zone)
	local seq=c:GetPreviousSequence()
	if c:IsPreviousControler(1-tp) then seq=seq+16 end
	return c:IsPreviousLocation(LOCATION_MZONE) and bit.extract(zone,seq)~=0
end
function c30822527.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c30822527.cfilter,1,nil,tp,e:GetHandler():GetLinkedZone())
end
function c30822527.cfilter2(c,tp,zone)
	return not c:IsReason(REASON_BATTLE) and c30822527.cfilter(c,tp,zone)
end
function c30822527.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c30822527.cfilter2,1,nil,tp,e:GetHandler():GetLinkedZone())
end
function c30822527.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+30822527,e,0,tp,0,0)
end
function c30822527.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c30822527.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsHasEffect(EFFECT_EXTRA_ATTACK) end
end
function c30822527.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
