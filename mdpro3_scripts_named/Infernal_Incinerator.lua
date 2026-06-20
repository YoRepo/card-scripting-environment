--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 炎狱魔人 地狱焚魔  (ID: 23309606)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fiend
-- Level 6
-- ATK 2800 | DEF 1800
-- Setcode: 109
--
-- Effect Text:
-- 不把除这张卡外的自己手卡全部丢弃去墓地，并用自己场上1只攻击力2000以上的怪兽作为祭品不能通常召唤。对方场上每存在1只怪兽，这张卡的攻击力上升200。自己场上这张卡以外的怪兽每存在1只，这张卡的攻击
-- 力下降500。
--[[ __CARD_HEADER_END__ ]]

--炎獄魔人ヘル・バーナー
function c23309606.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23309606,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(c23309606.otcon)
	e1:SetOperation(c23309606.otop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c23309606.val)
	c:RegisterEffect(e3)
end
function c23309606.otfilter(c,tp)
	return c:IsAttackAbove(2000) and (c:IsControler(tp) or c:IsFaceup())
end
function c23309606.otcon(e,c,minc)
	if c==nil then return true end
	local tp=c:GetControler()
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	hg:RemoveCard(c)
	local mg=Duel.GetMatchingGroup(c23309606.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	return hg:GetCount()>0 and minc<=1 and Duel.CheckTribute(c,1,1,mg)
		and hg:FilterCount(Card.IsAbleToGraveAsCost,nil)==hg:GetCount()
end
function c23309606.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	hg:RemoveCard(c)
	Duel.SendtoGrave(hg,REASON_COST+REASON_DISCARD)
	local mg=Duel.GetMatchingGroup(c23309606.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local sg=Duel.SelectTribute(tp,c,1,1,mg)
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
end
function c23309606.val(e,c)
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*-500+500+Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)*200
end
