--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 邪龙 阿难陀  (ID: 8400623)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: DARK
-- Race: Reptile
-- Level 8
-- ATK ? | DEF ?
--
-- Effect Text:
-- 这张卡不能通常召唤。从自己墓地以及自己场上的表侧表示怪兽之中把爬虫类族怪兽全部除外的场合才能特殊召唤。
-- ①：这张卡的攻击力·守备力变成因为这张卡特殊召唤而除外的怪兽数量×600。
-- ②：自己结束阶段，以场上1张卡为对象发动。这张卡在自己场上表侧表示存在的场合，作为对象的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--邪龍アナンタ
function c8400623.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c8400623.spcon)
	e2:SetOperation(c8400623.spop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(8400623,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c8400623.descon)
	e3:SetTarget(c8400623.destg)
	e3:SetOperation(c8400623.desop)
	c:RegisterEffect(e3)
end
function c8400623.cfilter(c)
	return c:IsRace(RACE_REPTILE) and c:IsAbleToRemoveAsCost()
		and (not c:IsLocation(LOCATION_MZONE) or c:IsFaceup())
end
function c8400623.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c8400623.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	return #g>0 and Duel.GetMZoneCount(tp,g)>0
end
function c8400623.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(c8400623.cfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,0,nil)
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetReset(RESET_EVENT+0xff0000)
	e1:SetValue(g:GetCount()*600)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
end
function c8400623.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c8400623.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c8400623.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() or c:IsControler(1-tp) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
