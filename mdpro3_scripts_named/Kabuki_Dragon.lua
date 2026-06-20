--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 歌舞伎龙  (ID: 7541475)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 6
-- ATK 2300 | DEF 2100
--
-- Effect Text:
-- ①：1回合1次，自己怪兽向对方怪兽攻击的伤害计算前才能发动。那只对方怪兽的表示形式变更。
-- ②：1回合1次，对方怪兽向自己怪兽攻击的伤害计算前才能发动。那只自己怪兽的表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--カブキ・ドラゴン
function c7541475.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7541475,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_CONFIRM)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c7541475.postg)
	e1:SetOperation(c7541475.posop)
	c:RegisterEffect(e1)
end
function c7541475.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d and d:GetControler()~=Duel.GetAttacker():GetControler() and d:IsCanChangePosition() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,d,1,0,0)
end
function c7541475.posop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.ChangePosition(d,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
