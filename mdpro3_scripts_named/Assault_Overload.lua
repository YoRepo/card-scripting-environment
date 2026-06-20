--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 爆裂爆发  (ID: 93469007)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 把自己场上存在的1只名字带有「/爆裂体」的怪兽解放发动。双方受到那只怪兽的等级×200的数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--バスター・バースト
function c93469007.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c93469007.cost)
	e1:SetTarget(c93469007.target)
	e1:SetOperation(c93469007.activate)
	c:RegisterEffect(e1)
end
function c93469007.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x104f) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x104f)
	e:SetLabel(g:GetFirst():GetLevel()*200)
	Duel.Release(g,REASON_COST)
end
function c93469007.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local res=e:GetLabel()~=0
		e:SetLabel(0)
		return res
	end
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,e:GetLabel())
	e:SetLabel(0)
end
function c93469007.activate(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Damage(1-tp,d,REASON_EFFECT,true)
	Duel.Damage(tp,d,REASON_EFFECT,true)
	Duel.RDComplete()
end
