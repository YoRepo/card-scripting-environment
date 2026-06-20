--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 十二兽 猴槌  (ID: 14970113)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Rank 4
-- ATK ? | DEF ?
-- Setcode: 241
--
-- Effect Text:
-- 4星怪兽×3只以上
-- 「十二兽 猴槌」1回合1次也能在同名卡以外的自己场上的「十二兽」怪兽上面重叠来超量召唤。
-- ①：这张卡的攻击力·守备力上升这张卡作为超量素材中的「十二兽」怪兽的各自数值。
-- ②：只要持有超量素材的这张卡在怪兽区域存在，对方不能把这张卡以外的场上的「十二兽」怪兽作为效果的对象。
-- ③：自己·对方的结束阶段发动。这张卡1个超量素材取除。
--[[ __CARD_HEADER_END__ ]]

--十二獣ハマーコング
function c14970113.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3,c14970113.ovfilter,aux.Stringid(14970113,0),99,c14970113.xyzop)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c14970113.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetValue(c14970113.defval)
	c:RegisterEffect(e2)
	--Cannot be effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c14970113.efftg)
	e3:SetCondition(c14970113.effcon)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--remove material
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(14970113,1))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c14970113.rmtg)
	e4:SetOperation(c14970113.rmop)
	c:RegisterEffect(e4)
end
function c14970113.ovfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xf1) and not c:IsCode(14970113)
end
function c14970113.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,14970113)==0 end
	Duel.RegisterFlagEffect(tp,14970113,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c14970113.atkfilter(c)
	return c:IsSetCard(0xf1) and c:GetAttack()>=0
end
function c14970113.atkval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c14970113.atkfilter,nil)
	return g:GetSum(Card.GetAttack)
end
function c14970113.deffilter(c)
	return c:IsSetCard(0xf1) and c:GetDefense()>=0
end
function c14970113.defval(e,c)
	local g=e:GetHandler():GetOverlayGroup():Filter(c14970113.deffilter,nil)
	return g:GetSum(Card.GetDefense)
end
function c14970113.efftg(e,c)
	return c:IsSetCard(0xf1) and c~=e:GetHandler()
end
function c14970113.effcon(e)
	return e:GetHandler():GetOverlayCount()>0
end
function c14970113.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c14970113.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
