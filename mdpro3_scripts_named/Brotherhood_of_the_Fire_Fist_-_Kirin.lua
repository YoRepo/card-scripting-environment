--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 罡炎星-麟俊麒  (ID: 89856523)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 8
-- ATK 2000 | DEF 2800
-- Setcode: 121
--
-- Effect Text:
-- 炎属性调整＋调整以外的名字带有「炎星」的怪兽1只以上
-- 这张卡同调召唤成功时，可以从卡组选1张名字带有「炎舞」的魔法·陷阱卡在自己场上盖放。只要这张卡在场上表侧表示存在，对方场上的怪兽的攻击力下降自己场上表侧表示存在的魔法·陷阱卡数量×100的数值。
--[[ __CARD_HEADER_END__ ]]

--罡炎星－リシュンキ
function c89856523.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_FIRE),aux.NonTuner(Card.IsSetCard,0x79),1)
	c:EnableReviveLimit()
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89856523,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c89856523.setcon)
	e1:SetTarget(c89856523.settg)
	e1:SetOperation(c89856523.setop)
	c:RegisterEffect(e1)
	--atkdown
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c89856523.atkval)
	c:RegisterEffect(e2)
end
function c89856523.setcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c89856523.filter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c89856523.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89856523.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c89856523.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c89856523.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c89856523.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c89856523.atkval(e,c)
	return Duel.GetMatchingGroupCount(c89856523.atkfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil)*-100
end
