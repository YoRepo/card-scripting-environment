--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 娱乐伙伴 额外射手  (ID: 45591967)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- Pendulum Scales: L6 / R6
-- ATK 800 | DEF 1100
-- Setcode: 159
--
-- Effect Text:
-- ←6 【灵摆】 6→
-- 「娱乐伙伴 额外射手」的灵摆效果1回合只能使用1次，这个效果发动的回合，自己不能灵摆召唤。
-- ①：自己主要阶段才能发动。给与对方为自己的额外卡组的表侧表示的灵摆怪兽数量×300伤害。
-- 【怪兽效果】
-- ①：1回合1次，从自己的额外卡组把1只怪兽除外，以自己或者对方的灵摆区域1张卡为对象才能发动。那张卡破坏，给与对方300伤害。
--[[ __CARD_HEADER_END__ ]]

--EMエクストラ・シューター
function c45591967.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45591967,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCountLimit(1,45591967)
	e1:SetCost(c45591967.dmcost)
	e1:SetTarget(c45591967.dmtg)
	e1:SetOperation(c45591967.dmop)
	c:RegisterEffect(e1)
	--Destroy & Damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45591967,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCost(c45591967.descost)
	e2:SetTarget(c45591967.destg)
	e2:SetOperation(c45591967.desop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(45591967,ACTIVITY_SPSUMMON,c45591967.counterfilter)
end
function c45591967.counterfilter(c)
	return not c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c45591967.dmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(45591967,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c45591967.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c45591967.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c45591967.dmfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c45591967.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c45591967.dmfilter,tp,LOCATION_EXTRA,0,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c45591967.dmfilter,tp,LOCATION_EXTRA,0,nil)*300
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c45591967.dmop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(c45591967.dmfilter,tp,LOCATION_EXTRA,0,nil)*300
	Duel.Damage(p,d,REASON_EFFECT)
end
function c45591967.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemoveAsCost,tp,LOCATION_EXTRA,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c45591967.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_PZONE,LOCATION_PZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c45591967.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,300,REASON_EFFECT)
	end
end
