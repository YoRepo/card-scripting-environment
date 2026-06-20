--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 爆炎集合体 地球之魂  (ID: 51355346)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 2000 | DEF 0
--
-- Effect Text:
-- 可以把自己场上最多2只炎族怪兽做祭品。因这个效果使用祭品的场合，这张卡的攻击力上升祭品数量×1000的数值。这张卡攻击守备表示怪兽时，若这张卡的攻击力超过守备表示怪兽的守备力，给与对方基本分那个数值的
-- 战斗伤害。结束阶段时这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--爆炎集合体 ガイヤ・ソウル
function c51355346.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51355346,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c51355346.atkcost)
	e1:SetOperation(c51355346.atkop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51355346,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetTarget(c51355346.destg)
	e3:SetOperation(c51355346.desop)
	c:RegisterEffect(e3)
end
function c51355346.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,e:GetHandler(),RACE_PYRO) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,2,e:GetHandler(),RACE_PYRO)
	Duel.Release(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c51355346.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		e1:SetValue(e:GetLabel()*1000)
		c:RegisterEffect(e1)
	end
end
function c51355346.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c51355346.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.Destroy(c,REASON_EFFECT)
	end
end
