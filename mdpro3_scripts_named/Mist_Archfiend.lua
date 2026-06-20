--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 迷雾恶魔  (ID: 28601770)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 5
-- ATK 2400 | DEF 0
-- Setcode: 69
--
-- Effect Text:
-- ①：这张卡可以不用解放作召唤。
-- ②：这张卡的①的方法召唤的场合，结束阶段发动。这张卡破坏，自己受到1000伤害。
--[[ __CARD_HEADER_END__ ]]

--ミストデーモン
function c28601770.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28601770,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c28601770.ntcon)
	e1:SetOperation(c28601770.ntop)
	c:RegisterEffect(e1)
end
function c28601770.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c28601770.ntop(e,tp,eg,ep,ev,re,r,rp,c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(28601770,1))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetTarget(c28601770.destg)
	e1:SetOperation(c28601770.desop)
	e1:SetReset(RESET_EVENT+0xee0000)
	c:RegisterEffect(e1)
end
function c28601770.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1000)
end
function c28601770.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end
