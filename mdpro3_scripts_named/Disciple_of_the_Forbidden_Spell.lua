--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 封魔之传承者  (ID: 15595052)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 4
-- ATK 1700 | DEF 800
--
-- Effect Text:
-- 这张卡召唤·反转召唤·特殊召唤成功时，宣言和自己墓地存在的「封魔之传承者」同数目的属性。这张卡对宣言属性的怪兽进行攻击的场合，不进行伤害计算直接破坏那只怪兽。
--[[ __CARD_HEADER_END__ ]]

--封魔の伝承者
function c15595052.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(15595052,0))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c15595052.ancop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c15595052.ancop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,15595052)
	if ct>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
		local att=Duel.AnnounceAttribute(tp,ct,ATTRIBUTE_ALL)
		e:GetHandler():SetHint(CHINT_ATTRIBUTE,att)
		--destroy
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(15595052,1))
		e1:SetCategory(CATEGORY_DESTROY)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_BATTLE_START)
		e1:SetTarget(c15595052.destg)
		e1:SetOperation(c15595052.desop)
		e1:SetLabel(att)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c15595052.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=Duel.GetAttackTarget()
	if chk==0 then return c==Duel.GetAttacker() and bc and bc:IsFaceup() and bc:IsAttribute(e:GetLabel()) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c15595052.desop(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetAttackTarget()
	if bc:IsRelateToBattle() and bc:IsFaceup() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
