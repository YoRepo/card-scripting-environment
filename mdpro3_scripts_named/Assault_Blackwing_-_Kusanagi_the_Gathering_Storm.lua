--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 强袭黑羽-丛云之草薙剑鸟  (ID: 31114334)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Winged Beast
-- Level 9
-- ATK 3000 | DEF 1000
-- Setcode: 4147
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：「黑羽」怪兽为素材作同调召唤的这张卡当作调整使用。
-- ②：这张卡同调召唤时适用。这张卡的攻击力直到回合结束时上升那些作为同调素材的同调怪兽的原本攻击力的合计数值。
-- ③：这张卡可以向对方怪兽全部各作1次攻击，向守备表示怪兽攻击的场合，给与对方为攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--A BF－叢雲のクサナギ
local s,id,o=GetID()
function s.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--add type
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.tncon)
	e1:SetOperation(s.tnop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MATERIAL_CHECK)
	e2:SetValue(s.valcheck)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--attackall
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_ATTACK_ALL)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--pierce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e4)
end
s.treat_itself_tuner=true
function s.valcheck(e,c)
	local g=c:GetMaterial()
	local atk=0
	local sg=g:Filter(Card.IsType,nil,TYPE_SYNCHRO)
	if sg:GetCount()>0 then
		atk=sg:GetSum(Card.GetBaseAttack)
	end
	if g:IsExists(Card.IsSetCard,1,nil,0x33) then
		e:GetLabelObject():SetLabel(1,atk)
	else
		e:GetLabelObject():SetLabel(0,atk)
	end
end
function s.tncon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function s.tnop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res,atk=e:GetLabel()
	if res==1 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_TUNER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
	end
	if atk~=0 then
		Duel.Hint(HINT_CARD,0,id)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	end
end
