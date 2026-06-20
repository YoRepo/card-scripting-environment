--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 高等宝玉兽 黄玉虎  (ID: 72843899)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 1000
-- Setcode: 20532
--
-- Effect Text:
-- ①：场地区域没有「高等暗黑结界」存在的场合这只怪兽送去墓地。
-- ②：只要这张卡在怪兽区域存在，自己场上的「高等宝玉兽」怪兽的攻击力·守备力上升400，对方场上的怪兽的攻击力·守备力下降400。
-- ③：表侧表示的这张卡在怪兽区域被破坏的场合，可以不送去墓地当作永续魔法卡使用在自己的魔法与陷阱区域表侧表示放置。
--[[ __CARD_HEADER_END__ ]]

--A宝玉獣 トパーズ・タイガー
function c72843899.initial_effect(c)
	aux.AddCodeList(c,12644061)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	--self to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SELF_TOGRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCondition(c72843899.tgcon)
	c:RegisterEffect(e1)
	--send replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT_CB)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(c72843899.repcon)
	e2:SetOperation(c72843899.repop)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x5034))
	e3:SetValue(400)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetTarget(aux.TRUE)
	e4:SetValue(-400)
	c:RegisterEffect(e4)
	--def
	local e5=e3:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e6)
end
function c72843899.tgcon(e)
	return not Duel.IsEnvironment(12644061)
end
function c72843899.repcon(e)
	local c=e:GetHandler()
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE) and c:IsReason(REASON_DESTROY)
end
function c72843899.repop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetCode(EFFECT_CHANGE_TYPE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
	e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
	c:RegisterEffect(e1)
end
