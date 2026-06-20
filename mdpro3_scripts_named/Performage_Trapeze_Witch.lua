--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐法师 秋千魄力魔女  (ID: 33206889)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Spellcaster
-- Level 7
-- ATK 2400 | DEF 1800
-- Setcode: 198
--
-- Effect Text:
-- 「娱乐法师」怪兽×2
-- ①：只要这张卡在怪兽区域存在，自己场上的「娱乐法师」怪兽不会被自己的卡的效果破坏，对方不能把那些作为效果的对象。
-- ②：只要自己场上有「娱乐法师 秋千魄力魔女」以外的「娱乐法师」怪兽存在，对方怪兽不能选择这张卡作为攻击对象。
-- ③：自己的「娱乐法师」怪兽和对方怪兽进行战斗的攻击宣言时才能发动。那只对方怪兽的攻击力下降600。
--[[ __CARD_HEADER_END__ ]]

--Emトラピーズ・フォース・ウィッチ
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xc6),2,true)
	c:EnableReviveLimit()
	--indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(aux.AND(Card.IsSetCard,Card.IsFaceup),0xc6))
	e1:SetValue(aux.NOT(aux.indoval))
	c:RegisterEffect(e1)
	--cannot be targeted
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--cannot be attacked
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e3:SetCondition(s.atkcon)
	e3:SetValue(aux.imval1)
	c:RegisterEffect(e3)
	--decrease attack
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,0))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(s.atkcon2)
	e4:SetTarget(s.atktg)
	e4:SetOperation(s.atkop)
	c:RegisterEffect(e4)
end
function s.cfilter(c)
	return not c:IsCode(id) and c:IsFaceup() and c:IsSetCard(0xc6)
end
function s.atkcon(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function s.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or a:GetControler()==d:GetControler() or d:IsFacedown() or a:IsFacedown() then return end
	if a:IsControler(tp) and a:IsSetCard(0xc6) then e:SetLabelObject(d)
	elseif d:IsControler(tp) and d:IsSetCard(0xc6) then e:SetLabelObject(a)
	else return false end
	return true
end
function s.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc:IsOnField() end
	Duel.SetTargetCard(tc)
end
function s.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsControler(1-tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
