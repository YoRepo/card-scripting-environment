--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 火山恶魔  (ID: 32543380)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: FIRE
-- Race: Pyro
-- Level 8
-- ATK 3000 | DEF 1800
-- Setcode: 50
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己场上1张表侧表示的「烈焰加农炮-三叉戟式」送去墓地的场合可以特殊召唤。
-- ①：对方战斗阶段中，可以攻击的对方的攻击表示怪兽必须向这张卡作出攻击。
-- ②：这张卡战斗破坏怪兽送去墓地的场合发动。对方场上的怪兽全部破坏，给与对方破坏数量×500伤害。
--[[ __CARD_HEADER_END__ ]]

--ヴォルカニック・デビル
function c32543380.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c32543380.spcon)
	e1:SetTarget(c32543380.sptg)
	e1:SetOperation(c32543380.spop)
	c:RegisterEffect(e1)
	--must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c32543380.bpcon)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e3:SetValue(c32543380.atklimit)
	c:RegisterEffect(e3)
	--special summon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(32543380,0))
	e5:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetCondition(c32543380.descon)
	e5:SetTarget(c32543380.destg)
	e5:SetOperation(c32543380.desop)
	c:RegisterEffect(e5)
end
function c32543380.spfilter(c)
	return c:IsFaceup() and c:IsCode(21420702) and c:IsAbleToGraveAsCost()
end
function c32543380.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c32543380.spfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c32543380.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c32543380.spfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c32543380.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
end
function c32543380.bpcon(e)
	return Duel.IsTurnPlayer(1-e:GetHandlerPlayer()) and Duel.IsBattlePhase()
end
function c32543380.atklimit(e,c)
	return c==e:GetHandler()
end
function c32543380.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a~=c then d=a end
	return c:IsRelateToBattle() and c:IsFaceup()
		and d and d:IsLocation(LOCATION_GRAVE) and d:IsType(TYPE_MONSTER)
end
function c32543380.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c32543380.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end
