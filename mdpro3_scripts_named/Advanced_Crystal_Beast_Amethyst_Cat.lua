--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 高等宝玉兽 紫晶猫  (ID: 19963185)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 1200 | DEF 400
-- Setcode: 20532
--
-- Effect Text:
-- ①：场地区域没有「高等暗黑结界」存在的场合这只怪兽送去墓地。
-- ②：自己的「高等宝玉兽」怪兽可以直接攻击。那次直接攻击给与对方的战斗伤害变成一半。
-- ③：表侧表示的这张卡在怪兽区域被破坏的场合，可以不送去墓地当作永续魔法卡使用在自己的魔法与陷阱区域表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--A宝玉獣 アメジスト・キャット
function c19963185.initial_effect(c)
	aux.AddCodeList(c,12644061)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	--self to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SELF_TOGRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCondition(c19963185.tgcon)
	c:RegisterEffect(e1)
	--send replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c19963185.repcon)
	e2:SetOperation(c19963185.repop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c19963185.atktg)
	c:RegisterEffect(e3)
	--damage reduce
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c19963185.atkcon)
	e4:SetTarget(c19963185.atktg)
	e4:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
	c:RegisterEffect(e4)
end
function c19963185.tgcon(e)
	return not Duel.IsEnvironment(12644061)
end
function c19963185.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c19963185.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
end
function c19963185.atktg(e,c)
	return c:IsSetCard(0x5034)
end
function c19963185.atkcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
