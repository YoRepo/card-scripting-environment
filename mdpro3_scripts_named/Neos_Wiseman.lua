--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 新宇贤者  (ID: 5126490)
-- Type: Monster / Effect / SpecialSummon
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 10
-- ATK 3000 | DEF 3000
-- Setcode: 9
--
-- Effect Text:
-- 这张卡不能通常召唤。把自己的怪兽区域的表侧表示的「元素英雄 新宇侠」和「于贝尔」各1只送去墓地的场合才能特殊召唤。
-- ①：场上的这张卡不会被效果破坏。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤结束时发动。给与对方那只对方怪兽的攻击力数值的伤害。自己基本分回复那只对方怪兽的守备力的数值。
--[[ __CARD_HEADER_END__ ]]

--ネオス・ワイズマン
function c5126490.initial_effect(c)
	aux.AddCodeList(c,89943723,78371393)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c5126490.spcon)
	e2:SetTarget(c5126490.sptg)
	e2:SetOperation(c5126490.spop)
	c:RegisterEffect(e2)
	--damage&recover
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(5126490,0))
	e3:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(aux.dsercon)
	e3:SetTarget(c5126490.damtg)
	e3:SetOperation(c5126490.damop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c5126490.spfilter(c,tp)
	return c:IsFaceup() and c:IsAbleToGraveAsCost()
end
function c5126490.fselect(g,tp)
	return aux.mzctcheck(g,tp) and aux.gfcheck(g,Card.IsCode,89943723,78371393)
end
function c5126490.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c5126490.spfilter,tp,LOCATION_MZONE,0,nil)
	return g:CheckSubGroup(c5126490.fselect,2,2,tp)
end
function c5126490.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c5126490.spfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c5126490.fselect,true,2,2,tp)
	if sg then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	else return false end
end
function c5126490.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoGrave(g,REASON_SPSUMMON)
	g:DeleteGroup()
end
function c5126490.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return c:IsStatus(STATUS_OPPO_BATTLE) and bc~=nil end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,bc:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,bc:GetDefense())
end
function c5126490.damop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local atk=bc:GetAttack()
	local def=bc:GetDefense()
	if atk<0 then atk=0 end
	if def<0 then def=0 end
	Duel.Damage(1-tp,atk,REASON_EFFECT,true)
	Duel.Recover(tp,def,REASON_EFFECT,true)
	Duel.RDComplete()
end
