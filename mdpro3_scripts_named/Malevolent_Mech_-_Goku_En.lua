--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 邪神机-狱炎  (ID: 31571902)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Zombie
-- Level 6
-- ATK 2400 | DEF 1400
--
-- Effect Text:
-- ①：这张卡可以不用解放作召唤。
-- ②：这张卡的①的方法召唤的场合，结束阶段发动。这张卡送去墓地。那之后，自己受到这张卡的原本攻击力数值的伤害。这个效果在场上没有这张卡以外的不死族怪兽存在的场合进行发动和处理。
--[[ __CARD_HEADER_END__ ]]

--邪神機－獄炎
function c31571902.initial_effect(c)
	--summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31571902,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c31571902.ntcon)
	e1:SetOperation(c31571902.ntop)
	c:RegisterEffect(e1)
end
function c31571902.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c31571902.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31571902,1))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCondition(c31571902.tgcon)
	e1:SetTarget(c31571902.tgtg)
	e1:SetOperation(c31571902.tgop)
	e1:SetReset(RESET_EVENT+0xc6e0000)
	c:RegisterEffect(e1)
end
function c31571902.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c31571902.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c31571902.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c31571902.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,e:GetHandler():GetBaseAttack())
end
function c31571902.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SendtoGrave(c,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Damage(tp,2400,REASON_EFFECT)
	end
end
